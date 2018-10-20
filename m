From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Sat, 20 Oct 2018 15:47:57 +0200
Subject: [RFC PATCH v2 00/12] crypto: Adiantum support
In-Reply-To: <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
 <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
Message-ID: <CAHmME9qf9OAuFaHvyT7du9Dce7vESLgHt-KewTLsttpS9UxNeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milan,

On Sat, Oct 20, 2018 at 12:53 PM Milan Broz <gmazyland@gmail.com> wrote:
> Does it mean, that if Adiantum is based on Zinc, it can be no longer used
> for FDE (dm-crypt)? IOW only file-based encryption is possible?

No, don't worry. All I had in mind was the software implementations of
chacha12 and so forth. There aren't any current plans at this point to
change the scafolding underlying dm-crypt.

Jason
