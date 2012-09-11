From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Tue, 11 Sep 2012 14:14:11 +0530
Subject: [PATCH v2 0/3] arm/dts: omap: add dt data for MUSB
In-Reply-To: <504EF587.3080903@ti.com>
References: <1347345381-4390-1-git-send-email-kishon@ti.com>
 <504EF587.3080903@ti.com>
Message-ID: <CAAe_U6JoW36bWSamHkRV66JX5fZ3QkLQv=4XJr-MuaFgaRjOaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Tue, Sep 11, 2012 at 1:55 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> On 09/11/2012 08:36 AM, Kishon Vijay Abraham I wrote:
>> No major change from the previous version. Just removed the
>> omap-usb2 dt data and sent that as a separate patch.
>
> Well, I think you'd better keep them in the same series :-)
>
>> Rebased on
>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git musb
>
> Since it is DTS stuf, you should rebase that on top of the latest
> lo/devel-dt branch. All the latest DTS patches an in there for 3.7.

The ocp2scp data is not in linux-omap :-( And omap-usb2 has to be a
child of ocp2scp. So I used arm-soc tree to which ocp2scp stuff was
pulled into.
>
> While you are there, could you please rename the patches with "ARM: dts"
> prefix. It seems that this is the new convention :-)

Sure.

Thanks
Kishon
