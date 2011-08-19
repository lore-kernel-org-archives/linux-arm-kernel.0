From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 19 Aug 2011 02:59:55 +0100
Subject: [PATCH] ARM: S3C64XX: Remove un-used code
In-Reply-To: <1313498488-4296-1-git-send-email-banajit.g@samsung.com>
References: <1313498488-4296-1-git-send-email-banajit.g@samsung.com>
Message-ID: <20110819015955.GA1212@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 06:11:28PM +0530, Banajit Goswami wrote:
> Remove un-used backlight code for SMDK6410 board

Is the data actually wrong?  If not it'd seem better to finish hooking
it up properly than to remove it.
