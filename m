From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jan 2013 19:52:59 +0000
Subject: [PATCH] ARM: SAMSUNG: Gracefully exit on suspend failure
In-Reply-To: <CAH9JG2WxW=+8PwhZ6r7akmwq2B2Qf=MqB4sB6DQypS0hEmAdvQ@mail.gmail.com>
References: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
 <CAH9JG2WxW=+8PwhZ6r7akmwq2B2Qf=MqB4sB6DQypS0hEmAdvQ@mail.gmail.com>
Message-ID: <20130109195259.GR3931@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:46:45AM +0900, Kyungmin Park wrote:
> Hi,
> I wodner do you see the real case it's happened?
> It it's occured, does it better to find out the root cause?

No.  It's better that if it does happen, the system remains functional
so you _can_ debug why it happened.  If you cause the system to panic
then you have to find some other way to get information out of it.
