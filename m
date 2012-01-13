From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 13 Jan 2012 17:38:24 +0800
Subject: [PATCH] backlight: pwm_bl: move suspend/resume entries from
 platform_driver to driver.pm
In-Reply-To: <4F0FFA58.7010702@cn.fujitsu.com>
References: <1322704427-11876-1-git-send-email-Barry.Song@csr.com>
 <4F0FFA58.7010702@cn.fujitsu.com>
Message-ID: <CAGsJ_4zhe1C4hVzmpcQYS5LDzxM==M6acQEH2eXM5aCvnf+XNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Why not use SIMPLE_DEV_PM_OPS instead?
>

Mark's revision merged did use SIMPLE_DEV_PM_OPS

-barry
