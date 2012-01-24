From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jan 2012 20:02:46 +0000
Subject: [PATCH] max8997: Avoid spaces in regulator names
In-Reply-To: <1327404672-5459-1-git-send-email-k.lewandowsk@samsung.com>
References: <1327404672-5459-1-git-send-email-k.lewandowsk@samsung.com>
Message-ID: <20120124200246.GA1135@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 12:31:11PM +0100, Karol Lewandowski wrote:
> max8997-pmic instantiated from device tree uses names, not numerical
> ids to distinguish between outputs.
> 
> Replace spaces with underscores in said names to make it possible to
> describe these outputs as regulators in DTS.

I went ahead and applied this since even if there's a better solution
out there this will work for now and the worst it's going to do is make
the log messages a bit less pretty.

Please when sending patches try to use subjects appropriate for the
subsystem - in this case a regulator: prefix.
