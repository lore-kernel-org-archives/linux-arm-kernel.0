From: arjan@linux.intel.com (Arjan van de Ven)
Date: Thu, 22 Dec 2011 09:53:50 +0100
Subject: [linux-pm] [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <CAMQu2gxws83BUdj_eMbF0xpA1Mo_OA_MswE7KUm5pvbn3YbMuQ@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4EF1A0B4.5080307@linux.intel.com>
 <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
 <4EF1AA8A.8060304@linux.intel.com>
 <CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
 <4EF1CD49.9020800@linux.intel.com>
 <CAMbhsRRnKoR3YPWrZzVynVe+dcuU5v0siYvmp2vbBcS1hquC7Q@mail.gmail.com>
 <4EF2352C.3060102@linux.intel.com>
 <CAMbhsRSPCo9MSGp57Fv0sRdYUFcdwx8jEz1-CfX8LdKf8X4MVg@mail.gmail.com>
 <CAMQu2gxws83BUdj_eMbF0xpA1Mo_OA_MswE7KUm5pvbn3YbMuQ@mail.gmail.com>
Message-ID: <4EF2F01E.8060307@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2011 9:35 AM, Shilimkar, Santosh wrote:

> Indeed. The SOCs, Arch's which does support low power
> state independently and doesn't need any co-ordination between CPU's
> will continue to work same way as before with this series.

btw I think you misunderstand; I don't object to a need for something
like this, I am just very concerned that this may not be possible to be
done in a race-free way.
