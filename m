From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Tue, 24 May 2016 09:08:47 +0200
Subject: [PATCH 0/2 (linux-stable-4.5.y)] net: stmmac: MDIO fixes
In-Reply-To: <20160523153619.GA30179@kroah.com>
References: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
 <20160523153619.GA30179@kroah.com>
Message-ID: <5743FDFF.9000704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/23/2016 5:36 PM, Greg KH wrote:
> On Mon, May 23, 2016 at 03:17:41PM +0200, Giuseppe Cavallaro wrote:
>> These patches port some recent fixes for linux-4.5.y stable branch.
>> They fix the MDIO settings trying to cover the all possible scenario
>> when the stmmac is connected to a real transceiver or a switch.
>>
>> These patches are needed for Kernel 4.5 where Lime2, BananaPi and Cubieboard2
>> show problems when use the stmmac:
>>
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823493
>
> What are the git commit id for these patches in Linus's tree?

Commits are:

stmmac: fix MDIO settings

    a7657f128c279ae5796ab2ca7d04a7819f4259f0

and

Revert "stmmac: Fix 'eth0: No PHY found' regression"

    d7e944c8ddc0983640a9a32868fb217485d12ca2

Regards
Peppe

>
> thanks,
>
> greg k-h
>
>
