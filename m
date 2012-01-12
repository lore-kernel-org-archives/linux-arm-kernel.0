From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 12 Jan 2012 07:49:35 -0600
Subject: Clock API and "maximum rate"
In-Reply-To: <20120111165844.GL3226@page>
References: <CAKGA1bmZGxxSfwGkpdyt7c-UYUTj+mV2AZhmhCUSEKTd12Q+4Q@mail.gmail.com>
 <20120111165844.GL3226@page>
Message-ID: <CAKGA1bnZLDXEBAL4MPa48vKEkjn6t-0Umekgy2Y9c8p0Y8CLyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 10:58 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> Hi Matt,
>
> On Wed, Jan 11, 2012 at 10:30:15AM -0600, Matt Sealey wrote:
>> Just a curious question, is there any safe way in the current API or
>> even by peeking a little behind the scenes to find out what the
>> maximum clock rate would be for a given named clock or struct clk?
>
> How about:
>
> ? ? ? ?long max = clk_round_rate(clk, ~0LU);
>
> clk_round_rate() is one of the optional API calls though.

Luckily implemented in this case :) Seems to do the trick, thanks.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
