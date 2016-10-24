From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Oct 2016 12:54:14 -0700
Subject: [PATCH v1 0/3] Add support for Broadcom OTP controller
In-Reply-To: <CAADWXX-43-k2K2T1V5MQMd0z0V502wf1syNHERPfvNstOJw-3A@mail.gmail.com>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
 <CAADWXX-43-k2K2T1V5MQMd0z0V502wf1syNHERPfvNstOJw-3A@mail.gmail.com>
Message-ID: <e34f01b6-a059-9988-0f93-e5adb82a5436@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 12:39 PM, Linus Torvalds wrote:
> On Mon, Oct 24, 2016 at 12:12 PM, Jonathan Richardson
> <jonathan.richardson@broadcom.com> wrote:
>> This patch set adds support for Broadcom's OTP controller found on chips such
>> as Cygnus and Stingray. A node has been added to the Cygnus dts.
> 
> These patches fail DKIM and will thus be marked as spam for a lot of people.
> 
> The usual reason tends to be that you use the wrong smtp server that
> doesn't add the right signature. That's happened before with
> broadcom.com addresses.

The older setup was using smtphost.broadcom.com which we have now
documented as being invalid, here Jonathan used gmail directly (since
that's our mail provider now):

Received: from lbrmn-lnxub108.corp.ad.broadcom.com ([216.31.219.19])
        by smtp.gmail.com with ESMTPSA id
s89sm8325746qkl.44.2016.10.24.12.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 12:12:03 -0700 (PDT)

Is there something else we need to check? Here is what I read for the
cover-letter:

Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com;
       spf=pass (google.com: domain of
bcm-kernel-feedback-list.pdl+bncbdh5xfvr4ydrbbn2xhaakgqed7hz4rq at broadcom.com
designates 2607:f8b0:400c:c08::247 as permitted sender)
smtp.mailfrom=bcm-kernel-feedback-list.pdl+bncBDH5XFVR4YDRBBN2XHAAKGQED7HZ4RQ at broadcom.com;
       dmarc=pass (p=QUARANTINE dis=NONE) header.from=broadcom.com
-- 
Florian
