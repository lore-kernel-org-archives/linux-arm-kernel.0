From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Feb 2016 13:13:20 +0000
Subject: [PATCH v3 4/6] arm64: Enable dynamic CPU capacity initialization
In-Reply-To: <56B889F7.306@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-5-git-send-email-juri.lelli@arm.com>
 <56B889F7.306@arm.com>
Message-ID: <20160208131320.GA7265@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 12:28:39PM +0000, Dietmar Eggemann wrote:
> On 03/02/16 11:59, Juri Lelli wrote:

> > +bool arch_wants_init_cpu_capacity(void)
> > +{
> > +	return true;

> Isn't this a little bit too simple? Not every ARM/ARM64 platform is a
> heterogeneous one.

Does it matter?  Is there any problem with doing the callibration and
having it say that all the CPUs performs very similarly?  My
understanding was that this was simply saying it was worth checking to
see if there was some asymmetry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/48a34424/attachment.sig>
