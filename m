From: robherring2@gmail.com (Rob Herring)
Date: Mon, 6 Jul 2015 10:20:56 -0500
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <20150706123126.GG10705@atomide.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <20150506114417.GI30910@pali> <20150625050138.GL4156@atomide.com>
 <201507061423.23505@pali> <20150706123126.GG10705@atomide.com>
Message-ID: <CAL_JsqK193CBPwvDpPvpDSbGFRfkpxpox45parCoC+ofWE4hUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 6, 2015 at 7:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [150706 05:25]:
>>
>> into which file should I put documentation about new DT properties?
>
> If it's Linux generic like linux,revision, then how about

Just "revision" at the top level please. I'd prefer a string still,
but either is fine.

Rob
