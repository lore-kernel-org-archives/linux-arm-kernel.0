From: sjg@chromium.org (Simon Glass)
Date: Tue, 19 Apr 2011 19:40:39 -0700
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <4DA7A914.5020804@codeaurora.org>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
Message-ID: <BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 7:10 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/14/2011 04:00 PM, Simon Glass wrote:
>> From: Simon Glass <sjg@google.com>
>>
>> ARM uses its own BUG() handler which makes its output slightly different
>> from other archtectures.


>> Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks Stephen. Since there were no other comments I have submitted
this to RMK's patch tracking system.

Regards,
Simon

>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
