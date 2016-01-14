From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jan 2016 07:11:25 +0000
Subject: [PATCH 0/4] mailbox: A few fixes due for the v4.5-rc's
Message-ID: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

I assume you already have your pull-request set for the v4.5
merge window, so please take this and add them to your -fixes
branch.

Kind regards,
Lee

Lee Jones (4):
  mailbox: mailbox-test: Use more consistent format for calling
    copy_from_user()
  mailbox: mailbox-test: Remove unused variable
  mailbox: mailbox-test: Prevent memory leak
  mailbox: Stop using ENOSYS for anything other than unimplemented
    syscalls

 drivers/mailbox/mailbox-test.c | 16 +++++++++-------
 drivers/mailbox/mailbox.c      |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
1.9.1
