From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 17 Aug 2017 22:07:56 +0300
Subject: [PATCH 1/3] sound: ASoC: tegra: Remove SoC-specific Kconfig
 depends and selects
In-Reply-To: <20170817142639.ixe7pfzpfhwbhz5q@sirena.org.uk>
References: <20170730112220.15525-1-contact@paulk.fr>
 <20170731102309.GE26667@ulmo> <20170817142211.GH6854@ulmo>
 <20170817142639.ixe7pfzpfhwbhz5q@sirena.org.uk>
Message-ID: <1502996876.1287.2.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 17 ao?t 2017 ? 15:26 +0100, Mark Brown a ?crit :
> On Thu, Aug 17, 2017 at 04:22:11PM +0200, Thierry Reding wrote:
> 
> > do you want to pick this up, or would you rather provide an Acked-by 
> > so
> > that I can take it through the Tegra tree along with the defconfig
> > changes? I can provide a branch with this patch in case we ever need
> > it
> > for conflict resolution.
> 
> I don't know what this patch is, sorry.  I think I probably deleted
> the
> mail since the subject line indicates it's not for me.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing
> are
> doing and make sure your subject lines visually resemble what they're
> doing.

I have just sent out another version with a subject line that matches
what others have been doing (mainly, dropping the "sound:" prefix).

Cheers,

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170817/cf074c60/attachment.sig>
