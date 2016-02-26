From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 26 Feb 2016 13:58:26 +0200
Subject: [PATCH v5 0/8] Add MT8173 Video Encoder Driver and VPU Driver
In-Reply-To: <56CC1CAB.1060409@xs4all.nl>
References: <1456215081-16858-1-git-send-email-tiffany.lin@mediatek.com>
 <56CC1CAB.1060409@xs4all.nl>
Message-ID: <56D03DE2.1090400@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

<snip>

> Nice!
> 
> Can you try 'v4l2-compliance -s'? Note that this may not work since I know
> that v4l2-compliance doesn't work all that well with codecs, but I am
> curious what the output is when you try streaming.

Sorry for the off topic question.

Does every new v4l2 encoder/decoder driver must use v4l2 mem2mem device
framework, with other words is that mandatory?

-- 
regards,
Stan
