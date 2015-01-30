From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 30 Jan 2015 12:41:44 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
In-Reply-To: <54CB6440.1010002@gmail.com>
References: <E1YH5bU-0005mG-3L@bombadil.infradead.org>
 <54CB5267.5060004@gmail.com> <20150130113118.5523ed68@armhf>
 <54CB6440.1010002@gmail.com>
Message-ID: <20150130124144.501cf81d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jan 2015 12:00:16 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> Adapting the .config and removing drivers is actually not an option.
> IMHO, introducing DT was meant for a single multi-arch kernel that
> can be shipped with common Linux distros. Therefore, DT is the place
> you enable/disable available resources. You leave most of the SoC (and
> SoM) nodes disabled as long as you cannot tell if there is a
> corresponding connector available.

Well, I don't know too much about the hardware, and less about the
hardware modules (SoM?).

As seen in the Compulab documents, there are a lot of hardware modules.
For the DT, do you mean that there would be as many .dts's as the whole
number of connection possibilities?

I'd have better seen the inverted case as the actual empty cm-board dts:
enable every option in the (generic) .dts and let the vendor/user create
a specific .dts from this one for the board according to the installed
modules.

In any case, any real cm-a510 board should work with the
generic/full .dts even if some hardware modules are lacking. No?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
