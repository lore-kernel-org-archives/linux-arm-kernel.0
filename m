From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 5 Sep 2014 10:58:34 -0300
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <201409051552.05447@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201409051338.40988@pali> <20140905134542.GD20164@leverpostej>
 <201409051552.05447@pali>
Message-ID: <CAOMZO5BtUaYbQUhidgyPBFdARsFY=uYySYqXXmFEfPL8qTBbfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 5, 2014 at 10:52 AM, Pali Roh?r <pali.rohar@gmail.com> wrote:

> So what is your suggestion for identifing board (name/type) which
> will work with any kernel (and will not be broken again by kernel
> later)?

$ cat /sys/bus/soc/devices/soc0/machine
Freescale i.MX6 Quad SABRE Smart Device Board
