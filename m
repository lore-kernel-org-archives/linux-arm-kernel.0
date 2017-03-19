From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sun, 19 Mar 2017 15:57:56 +0200
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170318204324.GM21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
Message-ID: <4e7f91fa-e1c4-1cbc-2542-2aaf19a35329@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 03/18/2017 10:43 PM, Russell King - ARM Linux wrote:
> On Sat, Mar 18, 2017 at 12:58:27PM -0700, Steve Longerbeam wrote:
>> Can you share your gstreamer pipeline? For now, until
>> VIDIOC_ENUM_FRAMESIZES is implemented, try a pipeline that
>> does not attempt to specify a frame rate. I use the attached
>> script for testing, which works for me.
> 
> It's nothing more than
> 
>   gst-launch-1.0 -v v4l2src ! <any needed conversions> ! xvimagesink
> 
> in my case, the conversions are bayer2rgbneon.  However, this only shows
> you the frame rate negotiated on the pads (which is actually good enough
> to show the issue.)

I'm sorry for potential offtopic, but is bayer2rgbneon element found in
any officially supported by GStreamer plugin? Can it be a point of
failure?

--
With best wishes,
Vladimir
