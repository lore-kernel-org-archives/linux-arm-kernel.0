From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 19 Apr 2012 12:01:08 -0700
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <201204190857.19770.arnd@arndb.de>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <CAJOA=zNPKrSSL5wjNBwL9qie5sGv9j=k3rSAmsjbK-6jfJwbgQ@mail.gmail.com>
 <CAJOA=zO4E0YJ0OU9n-abbNd+0VXQGsFi5Tnu5y=riHSgqk=xMw@mail.gmail.com>
 <201204190857.19770.arnd@arndb.de>
Message-ID: <CAJOA=zNLhDHqXyEWkryMSRUCctsSPBUfjLUP7w8ck1PoDtxioQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 1:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 18 April 2012, Turquette, Mike wrote:
>> I've taken patches 02 - 06 into my -next branch. ?Patch 01 isn't for
>> me really, and I've not yet tested patch 07 (I'll take it everything
>> looks good). ?The rest of your series (08 - 13) should probably go
>> through Arnd.
>
> My preference would be to have the whole series go through your tree
> and move the implementation of the spear clock code to drivers/clk
> in the process. This will reduce interdependencies between the spear
> clock branch and other branches that have spear patches.

If Viresh moves his code to drivers/clk/ then I'll take it.

> I also think it's a good idea if you submit the clk patches to Linus
> directly for the next merge window, but it's ok to use arm-soc if
> that makes you feel more confident about it.

As I said in my previous mail, I'd prefer to send to Linus directly.
Sounds like we're in agreement.

Regards,
Mike
