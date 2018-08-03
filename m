From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 3 Aug 2018 13:40:59 +0200
Subject: [PATCH] ARM: shmobile: silk: Add DA9063 PMIC node
In-Reply-To: <20180803104811.2kfa456t7ytcft6s@katana>
References: <20180730111817.5636-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXib8fz3c41RX-70eA5w4ThM6e02ybmX=N=xXR6=F80KA@mail.gmail.com>
 <42d09bc8-a883-c3af-b0d6-0087b6e2558e@gmail.com>
 <CAMuHMdXSjLSsmU32tKo5tkS6+MipAXuVAUqkLYrXxmR07+eCEg@mail.gmail.com>
 <75d2797a-48db-4979-c059-d7359eb39cff@gmail.com>
 <20180803104811.2kfa456t7ytcft6s@katana>
Message-ID: <a2948be8-ee81-8357-6bae-0ba7bdbee62b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2018 12:48 PM, Wolfram Sang wrote:
> 
>>> Wolfram: do you like i2c slaves connected to multiple buses?
> 
> 'Like' would be an exaggeration, but if they are connected to multiple
> busses, this might be a reason to describe that. People could then in
> userspace bind/unbind to the bus they want? Not pretty, but there might
> be reasons for that?

Would that be useful for a PMIC ? I suspect it'd create quite a few
problems if the user could move PMIC between I2C busses at will and I
don't see any benefits.

-- 
Best regards,
Marek Vasut
