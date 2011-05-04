From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 04 May 2011 18:10:04 +0300
Subject: [PATCH 1/4] omap: consolidate touch screen initialization among
	different boards
In-Reply-To: <4DC15C60.9060401@gmail.com>
References: <cover.1303682352.git.mike@compulab.co.il>
	<1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il>
	<4DC15C60.9060401@gmail.com>
Message-ID: <4DC16C4C.6030506@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 05/04/11 17:02, Thomas Weber wrote:

> Hello,
>
> because ads7846_get_pendown_state() is not longer set in
> ads7846_platform_data, the ads7846_setup_pendown tries to request the
> pendown gpio and fails because the gpio is already requested.

Thanks, for testing.

I've sent a patch for this a couple of minutes ago.


-- 
Regards,
Igor.
