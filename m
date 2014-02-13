From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Feb 2014 11:33:31 -0800
Subject: [PATCH] iommu/exynos: Remove driver
In-Reply-To: <CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
 <CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
 <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
 <52F4E481.3050902@samsung.com>
 <CAL5jtJmfwajFD0cnYt6gOfFsZ5hGbFi=5kv8g4x23fY6qGBOew@mail.gmail.com>
Message-ID: <CAOesGMhH2WHvkaobewdnPeiThrWTfw0m4WWAZW98-iS2xdr+ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 10:21 PM, Kukjin Kim <kgene.kim@gmail.com> wrote:

> Just adding KyongHo Cho.
>
> If he can fixup for this time, it would be best solution because he knows
> well than others, I think.

It's not so much a matter of "fixup for this time", it's a about
having ownership of the driver, making sure it works (and keeps
working if there is related development). The posted patches have not
been followed through on and the result is a broken driver. :(

I definitely appreciate his expertise, and we should make sure that he
gets to review the code, but if someone else is able to spend time on
reworking the driver (or rewriting a newer one) and maintaining it
longer-term, then we should not stop them from doing so. And there is
no reason to keep broken stale code in the kernel meanwhile.


-Olof
