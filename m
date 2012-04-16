From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 16 Apr 2012 21:33:31 +0400
Subject: [PATCH V4 1/5] of: Implement managed of_iomap()
In-Reply-To: <CACxGe6t9+M5jQKkRduup7_wk4SKYu1SuTz7wzf0MEvo0poojRw@mail.gmail.com>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
 <201204161442.38725.arnd@arndb.de>
 <CACxGe6tec7y-9VNb9vNiPZhN6bt5MuMV0J18P_7Gk_pDwk-V=Q@mail.gmail.com>
 <CAOh2x=n0NfovyfCpcdoMo2a7yLtb=imm1U+R-1L-2ihZ52FUhw@mail.gmail.com>
 <CACxGe6tZhdvoJ60N8g5-P4UHWxB=699_bA2omEQa77u1hEEPrg@mail.gmail.com>
 <CAOh2x=mptNGkRB-+930Uim=Op9erOxreeTL=3+qfoFeVpWNEYQ@mail.gmail.com>
 <CACxGe6t9+M5jQKkRduup7_wk4SKYu1SuTz7wzf0MEvo0poojRw@mail.gmail.com>
Message-ID: <4F8C57EB.4050907@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/16/2012 09:06 PM, Grant Likely wrote:

>>> It isn't recommended anymore. Use the bus_type specific helpers instead.

>> Ok. So here is fixup for 3/5 of this patchset.

>> @Linus: I will merge this with PACH 3/5 and send pull request to Arnd.

>> fixup! pinctrl: Add SPEAr pinctrl drivers

> Cool, thanks.

> Now what you *could* do is something like devm_platform_ioremap() that
> gets the resource, does request_region() and ioremap().  That would
> cut a lot of boilerplate out of drivers.  :-)

    That is already done, called devm_request_and_ioremap().

WRB, Sergei
