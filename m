From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 5 Jan 2017 12:55:45 +0100
Subject: [PATCH 4/4] watchdog: tangox: Use watchdog core to install
 restart handler
In-Reply-To: <yw1xmvf5ohx2.fsf@unicorn.mansr.com>
References: <1483565318-25578-1-git-send-email-linux@roeck-us.net>
 <1483565318-25578-4-git-send-email-linux@roeck-us.net>
 <df7b5570-a44d-0c25-fedd-03a0891fdff3@sigmadesigns.com>
 <yw1xmvf5ohx2.fsf@unicorn.mansr.com>
Message-ID: <aaf896ca-d2f1-1a47-ef21-762db1e62a56@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2017 12:38, M?ns Rullg?rd wrote:

> Marc Gonzalez writes:
> 
>> Guenter, patch c7ef68c32265 states "Fixes: a3e376d26ace".
>> Is that true? I mean, they seem quite orthogonal; then again I know
>> nothing of this framework.
> 
> I don't see the relation of either of those to this patch.

There is none. I just happened to git log the file because
of this proposed patch.
