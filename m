From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Jan 2014 13:58:51 -0800
Subject: imx6 wand board lockdep warnings on boot
In-Reply-To: <CAGa+x84Oko25r+xE_Z3wrY_dVCrMcF5AKvbBBMcbyvAMTOSoqg@mail.gmail.com>
References: <CAGa+x84Oko25r+xE_Z3wrY_dVCrMcF5AKvbBBMcbyvAMTOSoqg@mail.gmail.com>
Message-ID: <CAOesGMiP2nzrACVr4xy5NTfKFOEwkyGdCU2_ZFYRNhv8B_ncPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 1:52 PM, Kevin Hilman <khilman@linaro.org> wrote:
> For awhile now, the wand boards have had some noisy lockdep warnings
> during boot, but I'm not sure if anyone is looking into them.  I see
> it on the wand-solo and wand-quad, but not the dual.  Full boot logs
> for all three are attached from v3.13.

Yeah, this one is known -- Russell has mentioned it in the past too.

This reminds me, I've been meaning to turn on lockdep on all defconfig
builds so that we get coverage on more platforms, but I haven't done
it yet.


-Olof
