From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Sat, 11 Mar 2017 10:20:39 -0800
Subject: [PATCH v5 21/39] UAPI: Add media UAPI Kbuild file
In-Reply-To: <20170311134931.GP3220@valkosipuli.retiisi.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-22-git-send-email-steve_longerbeam@mentor.com>
 <20170311134931.GP3220@valkosipuli.retiisi.org.uk>
Message-ID: <184c02bf-782d-6dbe-e603-a82ac8dcc8b6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/11/2017 05:49 AM, Sakari Ailus wrote:
> Hi Steve,
>
> On Thu, Mar 09, 2017 at 08:53:01PM -0800, Steve Longerbeam wrote:
>> Add an empty UAPI Kbuild file for media UAPI headers.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>
> The existing V4L2 UAPI headers are under include/uapi/linux. Could you use
> that directory instead?
>
> I actually wouldn't really object doing this but it should have been done in
> 2002 or so when the first V4L2 header was added. Now the benefit is
> questionable.
>

Agreed, I think the current headers should be moved to uapi/media
eventually, but for now I'll go ahead and put under uapi/linux.

Steve
