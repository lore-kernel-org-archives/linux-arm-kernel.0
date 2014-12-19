From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 19 Dec 2014 18:02:21 +0100
Subject: [PATCH] ALSA: atmel: fix building the ac97 driver for
 at91-multiplatform
In-Reply-To: <54943BF8.4050008@cogentembedded.com>
References: <1418944390-27719-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54943BF8.4050008@cogentembedded.com>
Message-ID: <20141219170221.GU4885@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 19/12/2014 at 17:53:44 +0300, Sergei Shtylyov wrote :
> >+#define cpu_is_at32ap7000() (0)
> 
>    () around 0 not needed at all.
> 

Do you want me to fix that and resubmit? I don't have strong opinion
about this.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
