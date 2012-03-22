From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 22 Mar 2012 17:40:50 -0600 (MDT)
Subject: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
In-Reply-To: <CAMrsUdLtC0iVk2qDDDXj2tteAzP5UQJXNvsCoJLEC9Yty2QjvQ@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <87limurpsx.fsf@ti.com>
 <CAMrsUdLtC0iVk2qDDDXj2tteAzP5UQJXNvsCoJLEC9Yty2QjvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1203221740140.24425@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 22 Mar 2012, Raja, Govindraj wrote:

> Sorry I for got to add that, here are details on what was tested.
> 
> 1.) OMAP2430 SDP : Boot tested with uart1 as console.
> 
> 2.) OMAP3430 SDP: Boot test, suspend/resume tests, retention off mode
>                                (checking retention and off mode count
> in cpu idle cases)
> 
> 3.) OMAP3630 - Beagle XM:  Boot test, suspend/resume tests, retention off mode
>                                             (checking retention and
> off mode count in cpu idle cases)
> 
> 4.) OMAP4430 - PANDA: Boot test, suspend/resume tests
> 
> 5.) OMAP4460 - PANDA: Boot test.

What kernel .config was used for these tests?


- Paul
