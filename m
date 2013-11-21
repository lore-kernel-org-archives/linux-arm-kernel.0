From: vaibhav.bedia@gmail.com (Vaibhav Bedia)
Date: Thu, 21 Nov 2013 16:01:26 -0500
Subject: Kernel build failing randomly
In-Reply-To: <20131121122253.GA2826@e103592.cambridge.arm.com>
References: <20131121122253.GA2826@e103592.cambridge.arm.com>
Message-ID: <CANacCWx0pW2p6637WgzXpYMOk+V=w7CwsJxm37pFLR9Mx+b5bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, Nov 21, 2013 at 7:22 AM, Dave Martin <Dave.Martin@arm.com> wrote:
>
> Check dmesg after this happens.  Recent kernels generally log info about
> process deaths like this.
>
> If your VM is low on resources, it's possible the OOM killer is killing
> the final link.
>

Just checked dmesg and OOM killer it is. Thanks!

Regards,
Vaibhav
