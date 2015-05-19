From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 May 2015 22:38:22 +0200
Subject: [PATCH] ARM: dts: mvebu: fix gpio misspelling in some dts files
In-Reply-To: <1432067238-4682-1-git-send-email-pbrobinson@gmail.com>
References: <1432067238-4682-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <20150519203822.GN21807@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:27:18PM +0100, Peter Robinson wrote:
> A few of the Marvell armadda/dove/kirkwood dts(i) files appear to
> have some gpio options misspelled as gpo.

Hi Peter

Did you check the datasheet for the SoCs? Some pins are GPO, not GPIO.

    Andrew
