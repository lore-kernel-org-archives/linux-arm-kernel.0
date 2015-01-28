From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 28 Jan 2015 14:52:33 -0600
Subject: [PATCH V2] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <54C910FF.7090308@i2se.com>
References: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
 <CAHrpEqQ-eoqM3W1hYcS6EPTmur1FSfm8TeEjYrtZ+PquavL86w@mail.gmail.com>
 <201501220039.02073.marex@denx.de>
 <20150128015131.22722.22882@quantum>
 <CAHrpEqSFfdWsCif_wZO2ToRpwOuC2yt45+HwOpGgv+B=EwKTCw@mail.gmail.com>
 <54C905CA.80908@i2se.com>
 <CAHrpEqQ=7EZNzpt1tmjBUrH8oDzjQmCCOrZaH8MBdmvV1+uFZg@mail.gmail.com>
 <54C910FF.7090308@i2se.com>
Message-ID: <CAHrpEqSVZTfbWvg7UaU3FmiU+KSqsONV0kYM_jbshNbREEM_YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 10:40 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The clk init for the i.MX28 in the kernel tries to the set
> IO0FRAC and IO1FRAC at once. So this patch fix this problem.

Okay, I am  fine. I suggest add comment about only change one FRAC once.
