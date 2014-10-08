From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 8 Oct 2014 10:52:09 +0100
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <1412712462.32313.127.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141007180954.GH27464@redhat.com>
 <1412712462.32313.127.camel@smoke>
Message-ID: <CAF7UmSx-jS42q9QR_r5VsUUpq5-ujR_7m5ssUbw3t1tE20ZpdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 October 2014 21:07, Geoff Levand <geoff@infradead.org> wrote:
> You need to use a UEFI kernel loader.

No such thing exists.
The "built-in Linux loader" is a u-boot emulator (try it, it will work
with a uImage on v7) added for early development purposes and
unfortunately released in the wild.
It will very shortly disappear from Linaro UEFI builds.

/
    Leif
