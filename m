From: bp@alien8.de (Borislav Petkov)
Date: Wed, 26 Jul 2017 17:55:48 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170726154515.GA11453@hc>
References: <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com>
 <20170726111946.GA6273@hc>
 <faa339c4-b087-d970-1099-3d6cf8186545@arm.com>
 <20170726131058.GA8665@hc>
 <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
 <20170726145522.GC28875@nazgul.tnic> <20170726151314.GA10696@hc>
 <20170726153502.GE28875@nazgul.tnic> <20170726154515.GA11453@hc>
Message-ID: <20170726155548.GF28875@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 05:45:15PM +0200, Jan Glauber wrote:
> The PMU/EDAC devices are all PCI devices do I need the 'struct pci_dev *'.
> I'm not aware of other ways to access these devices. Please enlighten
> me if I'm missing something.

Me enlighten you on Cavium hardware?! You're funny.

So I don't know whether the PCI hotplug code can run more than one
function upon PCI ID detection. Probably Greg will say, write a
multiplexer wrapper. :-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
