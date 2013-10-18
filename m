From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Oct 2013 11:30:19 +0100
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
In-Reply-To: <20131018003439.GG2443@sirena.org.uk>
References: <20130924124122.64834b2a@armhf>
 <20131018003439.GG2443@sirena.org.uk>
Message-ID: <20131018103019.GW25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 01:34:39AM +0100, Mark Brown wrote:
> The last set of DPCMish patches was reported to work so should be a
> fairly small refactoring away from being OK - the main thing is to
> create back end DAIs for the physical links and then put the widgets
> that manage the enable of the S/PDIF and I2S interfaces between the FE
> and BE DAIs instead of directly connecting them to widgets on the CODEC.

ROTFL.  You're now telling JF to do exactly what I did in my last patch.
Your two-faced-ness is utterly astounding.

"widgets that manage the enable of the S/PDIF and I2S interfaces between
the FE and BE DAIs" is exactly what I did and you told me that was wrong.
Make up your fscking mind.
