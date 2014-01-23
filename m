From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 23 Jan 2014 11:21:04 +0100
Subject: [PATCH] [media] s5p-mfc: Add Horizontal and Vertical search range
 for Video Macro Blocks
In-Reply-To: <019f01cf1823$7e020fa0$7a062ee0$%debski@samsung.com>
References: <1388400186-22045-1-git-send-email-amit.grover@samsung.com>
 <019f01cf1823$7e020fa0$7a062ee0$%debski@samsung.com>
Message-ID: <52E0ED10.2020901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/01/14 11:11, Kamil Debski wrote:
>> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
>> > b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
>> > index 4ff3b6c..a02e7b8 100644
>> > --- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
>> > +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
>> > @@ -208,6 +208,24 @@ static struct mfc_control controls[] = {
>> >  		.default_value = 0,
>> >  	},
>> >  	{
>> > +		.id = V4L2_CID_MPEG_VIDEO_HORZ_SEARCH_RANGE,
>> > +		.type = V4L2_CTRL_TYPE_INTEGER,
>> > +		.name = "horizontal search range of video macro block",
>
> This too should be property capitalised. Please mention the motion vectors
> too. 

And additionally length of the name string should not exceed 31 characters.

--
Thanks,
Sylwester
