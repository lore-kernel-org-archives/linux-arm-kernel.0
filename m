From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Sep 2013 11:51:27 +0100
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20130924124122.64834b2a@armhf>
References: <20130924124122.64834b2a@armhf>
Message-ID: <20130924105127.GB12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 12:41:22PM +0200, Jean-Francois Moine wrote:
> This patch adds S/PDIF input/output for mvebu DT boards.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Right, so if this goes in, then we're completely fucked for doing this
the way that Mark apparantly wants it to be done, because once these
DT properties go in, they're there to stay.
