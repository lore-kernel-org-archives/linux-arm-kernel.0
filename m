From: jon.medhurst@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 29 Nov 2011 14:06:08 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <20111129104255.GA2829@localhost.localdomain>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
 <CAH+eYFBM36VqYAqZdiZnMP7AODh_SqYQWuoFDSyS3BDZDvHU5A@mail.gmail.com>
 <20111128174122.GG2465@localhost.localdomain>
 <1322508033.2354.86.camel@computer2>
 <20111129104255.GA2829@localhost.localdomain>
Message-ID: <1322575568.4500.39.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-29 at 10:42 +0000, Dave Martin wrote:
> Do you care about being to able to set probes in Thumb user code when
> the kernel is not Thumb-2, or do you simply not support that scenario
> at all?  (Thinking about, I'm guessing we don't currently support that?)

kprobes are only designed to probe kernel code, that's what the 'k'
stands for. ;-)

-- 
Tixy
