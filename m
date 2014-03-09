From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Mar 2014 22:14:39 -0800
Subject: [GIT PULL] bcm pinctrl rename
In-Reply-To: <201402252018.34109.arnd@arndb.de>
References: <CAEPRUYpCVpV7HwuO6c95ybk3yp1teJgW-9qwyHnjKbs03C9bgQ@mail.gmail.com>
 <20140221222947.GB13233@quad.lixom.net>
 <CAEPRUYqUNxOT=KnhSmbXbL2e2tCs=jAhQqKLiVVc13okpBxHnw@mail.gmail.com>
 <201402252018.34109.arnd@arndb.de>
Message-ID: <20140309061439.GC16310@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 08:18:33PM +0100, Arnd Bergmann wrote:
> On Tuesday 25 February 2014, Christian Daudt wrote:
> > Can you please pull the patches below. Note that if you wanto to
> > absolutely reduce this to the bone, you can drop the last patch in the
> > series titled "pinctrl: Rename Broadcom Capri pinctrl binding". That
> > is the documentation fixup, so the binding doc will be wrong until
> > 3.15. But that will reduce the change to just 2 lines :)
> 
> I've gone through the remaining pull requests today but didn't touch
> this one. Since Olof asked for the changes, I'm expecting him to
> look at the new version first. I don't have an opinion on the contents
> myself.

Yep, pulled now.

I noticed a typo in one of the binding file examples that you might want
to fix, but it's not urgent for 3.14:


@@ -119,7 +119,7 @@ Optional Properties (for HDMI pins):
 Example:
  // pin controller node
pinctrl at 35004800 {
-       compatible = "brcm,capri-pinctrl";
+       compatible = "brcmbcm11351-pinctrl";
	reg = <0x35004800 0x430>;


-Olof
