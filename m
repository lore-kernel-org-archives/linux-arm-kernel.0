From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Feb 2017 14:25:50 +0100
Subject: [PATCH] security/keys: add CONFIG_KEYS_COMPAT to Kconfig
In-Reply-To: <CAOe_czuM1hdECu=ByWzs-fBmDS2Xo1f+TFshdO+MkcePU11ZKg@mail.gmail.com>
References: <201701262036.mMS7eB5U%fengguang.wu@intel.com>
 <1485437243-9349-1-git-send-email-bilal.amarni@gmail.com>
 <CAOe_czuM1hdECu=ByWzs-fBmDS2Xo1f+TFshdO+MkcePU11ZKg@mail.gmail.com>
Message-ID: <CAK8P3a3tHb=ogt=Ym1+V0c6pfGMjCd2m1vm6X87gQaY2vALRvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 2:01 PM, Bilal Amarni <bilal.amarni@gmail.com> wrote:
> Hi Arnd,
>
> I've made the patch more generic as requested. As the patch affects
> now other architectures, is it still able to go through arm mailing
> list?

It would be good to get an Ack from the other architecture maintainers, you
need to add them to Cc in the submission. The best person to merge the
combined patch would be  the keyring maintainer, so send the patch 'To'
him (from MAINTAINERS file):

KEYS/KEYRINGS:
M:      David Howells <dhowells@redhat.com>
L:      keyrings at vger.kernel.org
S:      Maintained

   Arnd
