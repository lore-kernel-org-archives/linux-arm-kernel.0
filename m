From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 1 Jul 2016 14:20:14 +0200
Subject: [PATCH v5 0/2] [media] atmel-isc: add driver for Atmel ISC
In-Reply-To: <1466153854-30272-1-git-send-email-songjun.wu@atmel.com>
References: <1466153854-30272-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <e96fe150-2e5c-5ffa-3c1b-99e55fa4bff0@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Songjun,

First of all, please CC patch 2/2 to linux-media as well the next time you post this.
I only see 1/2 on the mailinglist, and we need both.

Secondly, before I can accept it you need to run the v4l2-compliance test first and
I need to see the output of that test.

The compliance test is here: https://git.linuxtv.org/v4l-utils.git. Always compile it from
the repository so you know you are using the latest most up to date version.

Since this driver supports multiple pixelformats you need to test with the -f option,
which tests streaming for all pixelformats.

Obviously, there shouldn't be any FAILs :-)

I greatly simplifies the code review if I know it passes the compliance test.

Regards,

	Hans
