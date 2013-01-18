From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 18 Jan 2013 18:40:40 +0530
Subject: [PATCH] ARM: SAMSUNG: Gracefully exit on suspend failure
In-Reply-To: <CAH9JG2WxW=+8PwhZ6r7akmwq2B2Qf=MqB4sB6DQypS0hEmAdvQ@mail.gmail.com>
References: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
 <CAH9JG2WxW=+8PwhZ6r7akmwq2B2Qf=MqB4sB6DQypS0hEmAdvQ@mail.gmail.com>
Message-ID: <CAM4voanVpYL3xXqa7nAtioHh6Q5VMHuZ1z+VQmQGNvv=bcLtFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 10, 2013 at 1:16 AM, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
> I wodner do you see the real case it's happened?
> It it's occured, does it better to find out the root cause?
>
We have seen infrequent suspend failures on the Exynos5. This patch
helps us obtain
failure statistics over a period of time and continue debugging the issue.
> Thank you,
> Kyungmin Park

Abhilash
