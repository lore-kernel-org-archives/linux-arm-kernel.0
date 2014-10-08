From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Oct 2014 11:07:03 +0100
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <CAF7UmSx-jS42q9QR_r5VsUUpq5-ujR_7m5ssUbw3t1tE20ZpdA@mail.gmail.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141007180954.GH27464@redhat.com>
 <1412712462.32313.127.camel@smoke>
 <CAF7UmSx-jS42q9QR_r5VsUUpq5-ujR_7m5ssUbw3t1tE20ZpdA@mail.gmail.com>
Message-ID: <20141008100703.GI27216@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 10:52:09AM +0100, Leif Lindholm wrote:
> On 7 October 2014 21:07, Geoff Levand <geoff@infradead.org> wrote:
> > You need to use a UEFI kernel loader.
> 
> No such thing exists.
> The "built-in Linux loader" is a u-boot emulator (try it, it will work
> with a uImage on v7) added for early development purposes and
> unfortunately released in the wild.
> It will very shortly disappear from Linaro UEFI builds.

To further Leif's point, the "built-in Linux loader" is not in the UEFI
spec, and is therefore not a portion of UEFI. It is a crutch, and it
should not be relied upon as anything more than an aid during bringup.

Mark.
