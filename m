From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Mar 2013 15:12:06 -0300
Subject: [PATCH 1/1 v2 net-next] net: fec: fix the build as module
In-Reply-To: <CAHrpEqQU9e-qAYvtHmB9bDhXafHmG=yWJxxv96f94FxVq9QYgQ@mail.gmail.com>
References: <1363915193-22179-1-git-send-email-Frank.Li@freescale.com>
 <CAOMZO5D1p-QJ=7N-QrLbjcwK0b=280QEFuxNkbmYsmTeRitv+w@mail.gmail.com>
 <CAHrpEqQU9e-qAYvtHmB9bDhXafHmG=yWJxxv96f94FxVq9QYgQ@mail.gmail.com>
Message-ID: <CAOMZO5Cn4xG38fB9snS2cJSjZDzaWQJSGLp3+hFyxTXmOkO7BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 11:39 PM, Frank Li <lznuaa@gmail.com> wrote:
>>
>> This error does not not happen in 'net-next' anymore.
>
> what's your suggestion? change commit message or request apply to 3.9

Your motivation now is to generate a single kernel module instead of
two for the fec, rather than fixing the the build error.

So you need to adjust the Subject and commit log.

I am not sure if we really need to rename fec.c though.
