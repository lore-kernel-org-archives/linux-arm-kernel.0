From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 7 Feb 2018 13:00:23 +0100
Subject: [PATCH v5 03/16] media: rkisp1: Add user space ABI definitions
In-Reply-To: <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
Message-ID: <e6160bef-29af-3905-6535-a18cb0caa601@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/17 08:52, Shunqian Zheng wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add the header for userspace

General note: I saw four cases where this documentation referred to the
datasheet. Three comments on that:

1) You don't say which datasheet.
2) I assume the datasheet is under NDA?
3) You do need to give enough information so a reasonable default can be
   used. I mentioned in an earlier review that creating an initial params
   struct that can be used as a templete would be helpful (or even
   required), and that would be a good place to put such defaults.

Regards,

	Hans
