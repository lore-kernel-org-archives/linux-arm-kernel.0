From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 29 Jul 2014 15:33:10 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <351673188.FxXsM7MvdA@wuerfel>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140729112824.GM2576@leverpostej>
 <CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>
 <351673188.FxXsM7MvdA@wuerfel>
Message-ID: <CAMJs5B9NePv=txgYY8mdMtiCO_LXVg6s6=OY3w-YBkOJpHSROw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2014 14:52, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
>>
>> For reference, Red Hat's current arguing point for ACPI in VMs is
>> hotplug of things like CPUs and memory for very large VMs, but I
>> haven't thought too carefully about this just yet, as I don't have a
>> 100+ core ARM 64-bit hardware lying around...
>
> I thought you could run guests with more virtual CPUs that you have
> physical CPUs on the host.
>

you can, my sentence was meant to be a bit tongue-in-cheek, running
100 VCPUs on the Foundation Model (which is the only thing I have on
my desk as of now) is not very useful, so I just don't care at this
point.  Let me see or give me access to something with at least 8
physical cores before I start caring (with my community hat on, as a
Linaro employee I may be told to care).

> Regarding CPU and memory hotplug, don't we already have PSCI and
> xen-balloon/virtio-balloon for that?
>
Virtio-balloon don't do anything for you wrt. CPUs, wrt. memory you
have to provision it beforehand.

-Christoffer
