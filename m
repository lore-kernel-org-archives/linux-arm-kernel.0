From: rubini@unipv.it (Alessandro Rubini)
Date: Sat, 2 Apr 2011 23:19:54 +0200
Subject: [PATCH] arm: nomadik: avoid assigning u32 to bool
In-Reply-To: <BANLkTikAG4diz-A6qfFx4cODvyR0c4oQ6g@mail.gmail.com>
References: <BANLkTikAG4diz-A6qfFx4cODvyR0c4oQ6g@mail.gmail.com>
	<20110401235113.083787a7@absol.kitzblitz>
Message-ID: <20110402211954.GA22545@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -       enabled = nmk_chip->enabled & bitmask;
>> +       enabled = !!(nmk_chip->enabled & bitmask);
> 
> I've learned to live this way of casting stuff into boolean,

I use (and love) !! since I learnt C. What I really dislike is the
concept of boolean that doesn't fit in the C way of thinking, in my opinion.
But I'm not going to change that.

Acked-by: Alessandro Rubini <rubini@unipv.it>

/alessandro
