From: bp@alien8.de (Borislav Petkov)
Date: Tue, 25 Apr 2017 19:46:41 +0200
Subject: [PATCH V15 06/11] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <6d7249d3-e0b2-afa7-b5fa-8e85c40d8a13@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-7-git-send-email-tbaicar@codeaurora.org>
 <20170425172154.ggg56j52inf3522e@pd.tnic>
 <6d7249d3-e0b2-afa7-b5fa-8e85c40d8a13@codeaurora.org>
Message-ID: <20170425174641.bfzwr4h3eoaxtcor@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 11:41:39AM -0600, Baicar, Tyler wrote:
> I originally had this as a notifier, but Will requested to remove the
> notifier. That conversation is here: https://lkml.org/lkml/2017/1/18/1018

Yeah, he mentioned on IRC. I just think notifiers would be the cleaner
thing but whatever you guys say.

Just we had a nasty hack on x86 which I got rid of recently:

https://lkml.kernel.org/r/20170406090634.30950-1-bp at alien8.de

and I wouldn't want you guys to have the same "fun". :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
