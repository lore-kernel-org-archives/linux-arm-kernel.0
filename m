From: bp@alien8.de (Borislav Petkov)
Date: Wed, 26 Jul 2017 17:28:01 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <0a0daa94-bad7-cbb5-e421-f8e9d6c79d54@arm.com>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com>
 <20170726111946.GA6273@hc>
 <faa339c4-b087-d970-1099-3d6cf8186545@arm.com>
 <20170726131058.GA8665@hc>
 <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
 <20170726145522.GC28875@nazgul.tnic> <20170726151314.GA10696@hc>
 <0a0daa94-bad7-cbb5-e421-f8e9d6c79d54@arm.com>
Message-ID: <20170726152801.GD28875@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 04:17:11PM +0100, Suzuki K Poulose wrote:
> How about adding a soc specific (wrapper) driver for the memory controller, which
> could use the PCI id and trigger EDAC and PMU drivers (based on what is
> selected by configs)  ?

That was the last idea on my list if nothing slicker comes up. Having a
"multiplexer" driver just for the loading is meh.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
