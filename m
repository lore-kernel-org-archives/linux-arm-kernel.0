From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 May 2016 14:09:24 -0700
Subject: [PATCH v8 7/8] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <57349C36.4030401@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908698-27284-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=Uf-U3RBpgFbR3LkPAJTWqz3d02+H7iyA-SS-y=r3cXjA@mail.gmail.com>
 <5733D7AA.1060500@rock-chips.com> <57349C36.4030401@rock-chips.com>
Message-ID: <CAD=FV=W1-DDtuLUzW1uLiFxuhpnmhnKB1od_yweY=WJ-4u3=kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Thu, May 12, 2016 at 8:07 AM, David.Wu <david.wu@rock-chips.com> wrote:
> I also found a subtle bug, it would clean the con register by use
> "i2c_writel(i2c, 0, REG_CON)" in rk3x_i2c_stop(). So i think it would be
> fixed by using read-modify-write way here in next version.

Good catch.  I look forward to the next version (maybe the last
version, since this series is looking really good).

-Doug
