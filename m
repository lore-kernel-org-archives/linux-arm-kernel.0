From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Jul 2013 19:36:45 -0300
Subject: mx6q boot on linux-next 20130703
In-Reply-To: <20130704064149.GD14617@S2101-09.ap.freescale.net>
References: <CAOMZO5DgAu2-cknESp4a675KP5gDrJxM2A_FqUgAZav83Db=fw@mail.gmail.com>
 <CAOMZO5AvXJJHmoEu3BMN=EYCxS4O1-2ivsSzS2eCuyPeiw_brQ@mail.gmail.com>
 <20130704064149.GD14617@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5ALV-cMaMfcgy6QD2=nA=R8xAGMmd=jbm1uWVFsvs-0vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 4, 2013 at 3:41 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Jul 04, 2013 at 01:08:13AM -0300, Fabio Estevam wrote:
>> On Wed, Jul 3, 2013 at 8:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> > Hi,
>> >
>> > I am running linux-next 20130703 on a mx6q board, and seeing a strange
>> > behaviour.
>> >
>> > Only if I enable DEBUG_LL + earlyprintk and disable
>
> Yes, I see the issue here too, and turning on earlyprintk can remove the
> issue.

linux-next 20130708 does not have this issue anymore.
