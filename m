From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:51:36 +0900
Subject: [PATCH 14/17] ARM: S5PV310: Define I2S clocks
In-Reply-To: <AANLkTi=sh4if3FhU2-yUrFCUAtjWm4mDaMcf_JSTU8ia@mail.gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
	<1292562014-20036-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTi=sh4if3FhU2-yUrFCUAtjWm4mDaMcf_JSTU8ia@mail.gmail.com>
Message-ID: <AANLkTik0ob0bx0OBzG2Y2-mx-U=HUwuK1hzJwj8tRMZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 2:44 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>
> Don't you use the i2s instead of iis?

The already present driver expects 'iis' so we have to call it so, atm.
