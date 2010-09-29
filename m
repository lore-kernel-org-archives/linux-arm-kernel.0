From: soni.trilok@gmail.com (Trilok Soni)
Date: Wed, 29 Sep 2010 17:42:31 +0530
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<4CA1AD2B.8000905@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
	<4CA1BC16.3020702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FC60@EXDCVYMBSTM006.EQ1STM.local>
	<4CA25841.4090702@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC8B7E4@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <AANLkTingb8ox5h5rN1YrxONibfrWLicoiS6yqKf_v5bJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

Adding Bill Gatliff (anyway, CC list already crowded)

On Wed, Sep 29, 2010 at 10:19 AM, Arun MURTHY
<arun.murthy@stericsson.com> wrote:
>> Arun MURTHY wrote:
>> >>>> Shouldn't PWM_DEVICES select HAVE_PWM?
>> >>>
>> >>> No not required, the entire concept is to remove HAVE_PWM and use
>> >> PWM_CORE.

There is already nice and clean framework written by Bill for PWM, if
you grep the LKML and linux-embedded mailing list archive then you
will get his patches, and it seems that he had promised to send the
updated version few week back, but not heard from him (may be because
he was travelling as per FB status).

Please evaluate that framework too.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
