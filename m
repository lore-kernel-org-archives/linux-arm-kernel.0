From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 31 Oct 2013 16:48:28 -0500
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAOMZO5DAAXg4wP2UuYCN6BgN5-q3sv0Lrqvk8xMDmEW_TXepXg@mail.gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
 <5272BC59.1080109@boundarydevices.com>
 <5272BFE0.5040409@boundarydevices.com>
 <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
 <20131031210053.GH16735@n2100.arm.linux.org.uk>
 <CAOMZO5DAAXg4wP2UuYCN6BgN5-q3sv0Lrqvk8xMDmEW_TXepXg@mail.gmail.com>
Message-ID: <CAHCPf3v0G_551Oeq-dL61J0Ce-iUMv+ou8+q671S8=GEcNjv5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 4:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Oct 31, 2013 at 7:00 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>>> Interesting. With the monitor I have tested I am not able to see this
>>> magenta line.
>>
>> Monitor or TV?  Beware of overscans which will hide this effect.
>
> I used a PC monitor on my tests.
>
> I sent v5 using 4 as the number of loops according to Troy's results.

Stop, stop, stop!

Has nobody noticed this register isn't described in the reference manual?

What does it even do? How can we quantify Troy's results by just
throwing numbers at it and then saying "no magenta line here"?

Growl,
Matt Sealey <neko@bakuhatsu.net>
