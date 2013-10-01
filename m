From: yrehan@gmail.com (Mian Yousaf Kaukab)
Date: Tue, 1 Oct 2013 22:15:41 +0200
Subject: [PATCH] ARM: vexpress: ignore MIDR[0] for uart detection
In-Reply-To: <1380645555.30015.8.camel@hornet>
References: <1380449869-19911-1-git-send-email-yrehan@gmail.com>
 <CAC_HJnzfvi59i0e0-VwhUtKPxiPLU9o+Y6Dvts9HVkKC6gyqRw@mail.gmail.com>
 <1380645555.30015.8.camel@hornet>
Message-ID: <CAC_HJnxrjDZXxUrUMMNgx+mtbJko2f3rJGnsHSRKf_k+T4jkPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 1, 2013 at 6:39 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> To be honest, I have rather mixed feelings about it. In particular I
> could say that if qemu returns r0p0, it doesn't model V2P-CA9, which has
> A9 r0p1 :-) [...]

r0p0 looked legitimate to me :). Ok I will drive this with qemu developers then.

Thanks,

Yousaf
