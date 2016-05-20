From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 May 2016 18:37:38 -0300
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <4080948.V5DMHR9bsk@vostro.rjw.lan>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
 <4080948.V5DMHR9bsk@vostro.rjw.lan>
Message-ID: <CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Fri, May 20, 2016 at 6:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

>> If I rebuilt a kernel with SMP=n then the reboot command works as expected.
>
> Does it work if you boot with maxcpus=1 or nosmp in the kernel command line?

No, it does not help.

> Also, please try if the appended patch makes any difference.

I tried it, and the console shows "Requesting system reboot" and stays
there forever. No more messages after that and the system does not
reboot.
