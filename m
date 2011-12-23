From: eric.miao@linaro.org (Eric Miao)
Date: Fri, 23 Dec 2011 11:06:48 +0800
Subject: init_kprobes() takes too much time during boot up
Message-ID: <CAMPhdO8T5wwPBYp_n15A88o8YxkXv2t8WOumRyni6WDhJinS3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was trying to improve the kernel boot performance of the boards at
my hands, while simply turning on initcall_debug, and found that
init_kprobes() won the crown of being the most hungry time gobbler.

Before I take my time to look into why it's taking so much time, I'd
post the question to the list to seek help first.

- eric
