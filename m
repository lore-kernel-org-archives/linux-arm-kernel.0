From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 9 Nov 2015 22:59:13 -0600
Subject: [PATCH V3 3/4] dmaselftest: add memcpy selftest support functions
In-Reply-To: <564178A5.6080603@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
 <CAHp75VfS6iCYcWeFmbK2PEUYLntQQRdsmN=7gttFpOn=CfrSZg@mail.gmail.com>
 <56400DD4.5080506@codeaurora.org>
 <CAHp75Vddve-yv5DQ5UWhOsfUaY0JCb_rFjwGf2tvY-8++sJmng@mail.gmail.com>
 <564178A5.6080603@codeaurora.org>
Message-ID: <564179A1.2080304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
>
> OK. I did an internal code review before posting the patch. Nobody
> complained about iterator types. I am trying to find what goes as a good
> practice vs. what is personal style.

I normally check for inappropriate usage of sized integers in my 
reviews, but I admit I'm inconsistent about that sort of thing for 
internal reviews.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
