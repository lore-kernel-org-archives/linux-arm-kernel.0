From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 11 Jan 2016 13:49:38 -0300
Subject: [PATCH 0/8] [media] Check v4l2_of_parse_endpoint() ret val in all
 drivers
In-Reply-To: <20160109230330.GG576@valkosipuli.retiisi.org.uk>
References: <1452191248-15847-1-git-send-email-javier@osg.samsung.com>
 <20160109230330.GG576@valkosipuli.retiisi.org.uk>
Message-ID: <5693DD22.9020805@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sakari,

On 01/09/2016 08:03 PM, Sakari Ailus wrote:
> Hi Javier,
> 
> On Thu, Jan 07, 2016 at 03:27:14PM -0300, Javier Martinez Canillas wrote:
>> Hello,
>>
>> When discussing a patch [0] with Laurent Pinchart for another series I
>> mentioned to him that most callers of v4l2_of_parse_endpoint() weren't
>> checking the return value. This is likely due the function kernel-doc
>> stating incorrectly that the return value is always 0 but can return a
>> negative error code on failure.
>>
>> This trivial patch series fixes the function kernel-doc and add proper
>> error checking in all the drivers that are currently not doing so.
> 
> After fixing patches 5 and 6,
> 

Done, posted a v2 fixing the issues you pointed out.

> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 

Thanks a lot for your feedback and review!

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
