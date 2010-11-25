From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 24 Nov 2010 22:19:28 -0800
Subject: [PATCH v7 00/11] OMAP: GPIO: Implement GPIO as a platform device
In-Reply-To: <AANLkTi=wXjf9m-RTxnzTjP0H8EpjtG1529a6Ch2zbt6Z@mail.gmail.com>
References: <1290524213-395-1-git-send-email-charu@ti.com>
	<87lj4i2nb2.fsf@deeprootsystems.com>
	<AANLkTi=wXjf9m-RTxnzTjP0H8EpjtG1529a6Ch2zbt6Z@mail.gmail.com>
Message-ID: <AANLkTin6Sp1k-1sYYrRLc4T7z8gv9MgUOc7Yp8S3B53x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Charu,

[...]

>>
>> Please be sure your board file changes are updated for the board file
>> changes in the devel-board branch.
>
> Okay. But if it is different, should I send only the board files changes on
> devel-board ?branch as a separate patch mentioning the dependencies on
> my patch series?
>

My pm-core includes the devel-board branch since it's part of Tony's
for-next, so that shouldn't be necessary.

However, if you find it's easier to break it into separate series feel
free, as long as the dependencies are mentioned.

Thanks,

Kevin
