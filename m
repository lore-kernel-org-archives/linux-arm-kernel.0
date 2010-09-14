From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Sep 2010 15:20:34 +0800
Subject: Remove unused default configurations
In-Reply-To: <1284398671.4003.4.camel@c-dwalke-linux.qualcomm.com>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284398671.4003.4.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTin4q+AUWs6YUo38OeYd-CcxtHT6sJOSfK9BbN=e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 14, 2010 at 1:24 AM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Mon, 2010-09-13 at 16:13 +0100, Vincent Sanders wrote:
>> Several default configurations have failed to build for the entire
>> 2.6.36 cycle. There are several causes to these faliures. The exact
>> issues can be tracked on http://armlinux.simtec.co.uk/kautobuild/
>>
>> Obviously the maintainers are not using these default configurations
>> because if they were they would have fixed the build issues by now.
>>
>> As Linus has made it very clear the number of default configurations
>> must be reduced as much as possible I have come up with the following
>> series which will remove these nine unused configurations. This will
>> reduce our build coverage by ten machines as all but one are a single
>> config per machine.
>
> I can't speak for anyone else, but I would prefer to see fixes for the
> build issues.

+1

> ARM has way too many build issues.
>
> Daniel
>
> --
>
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
